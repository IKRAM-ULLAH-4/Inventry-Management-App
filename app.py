from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key-here'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///inventory.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Database Model
class InventoryItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    category = db.Column(db.String(50), nullable=False)
    quantity = db.Column(db.Integer, nullable=False, default=0)
    price = db.Column(db.Float, nullable=False, default=0.0)
    description = db.Column(db.Text, nullable=True)
    date_added = db.Column(db.DateTime, default=datetime.utcnow)
    last_updated = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def __repr__(self):
        return f'<InventoryItem {self.name}>'

# Routes
@app.route('/')
def index():
    items = InventoryItem.query.order_by(InventoryItem.date_added.desc()).all()
    total_items = sum(item.quantity for item in items)
    total_value = sum(item.quantity * item.price for item in items)
    return render_template('index.html', items=items, total_items=total_items, total_value=total_value)

@app.route('/add', methods=['GET', 'POST'])
def add_item():
    if request.method == 'POST':
        name = request.form.get('name')
        category = request.form.get('category')
        quantity = request.form.get('quantity', type=int)
        price = request.form.get('price', type=float)
        description = request.form.get('description')

        if not name or not category or quantity is None or price is None:
            flash('Please fill in all required fields!', 'error')
            return redirect(url_for('add_item'))

        new_item = InventoryItem(
            name=name,
            category=category,
            quantity=quantity,
            price=price,
            description=description
        )
        
        try:
            db.session.add(new_item)
            db.session.commit()
            flash(f'Item "{name}" added successfully!', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error adding item: {str(e)}', 'error')
            return redirect(url_for('add_item'))

    return render_template('add_item.html')

@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_item(id):
    item = InventoryItem.query.get_or_404(id)
    
    if request.method == 'POST':
        item.name = request.form.get('name')
        item.category = request.form.get('category')
        item.quantity = request.form.get('quantity', type=int)
        item.price = request.form.get('price', type=float)
        item.description = request.form.get('description')
        item.last_updated = datetime.utcnow()

        try:
            db.session.commit()
            flash(f'Item "{item.name}" updated successfully!', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error updating item: {str(e)}', 'error')

    return render_template('edit_item.html', item=item)

@app.route('/delete/<int:id>')
def delete_item(id):
    item = InventoryItem.query.get_or_404(id)
    
    try:
        db.session.delete(item)
        db.session.commit()
        flash(f'Item "{item.name}" deleted successfully!', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error deleting item: {str(e)}', 'error')
    
    return redirect(url_for('index'))

@app.route('/search')
def search():
    query = request.args.get('q', '')
    if query:
        items = InventoryItem.query.filter(
            (InventoryItem.name.contains(query)) | 
            (InventoryItem.category.contains(query)) |
            (InventoryItem.description.contains(query))
        ).all()
    else:
        items = []
    
    return render_template('search.html', items=items, query=query)

# Initialize database
def init_db():
    with app.app_context():
        db.create_all()
        
        # Add sample data if database is empty
        if InventoryItem.query.count() == 0:
            sample_items = [
                InventoryItem(name='Laptop', category='Electronics', quantity=10, price=999.99, 
                             description='High-performance laptop with 16GB RAM'),
                InventoryItem(name='Wireless Mouse', category='Electronics', quantity=50, price=29.99,
                             description='Ergonomic wireless mouse with USB receiver'),
                InventoryItem(name='Office Chair', category='Furniture', quantity=15, price=199.99,
                             description='Comfortable ergonomic office chair'),
                InventoryItem(name='Notebook', category='Stationery', quantity=100, price=2.99,
                             description='A4 lined notebook'),
                InventoryItem(name='Desk Lamp', category='Furniture', quantity=20, price=39.99,
                             description='LED desk lamp with adjustable brightness'),
            ]
            
            for item in sample_items:
                db.session.add(item)
            
            try:
                db.session.commit()
                print('Sample data added successfully!')
            except Exception as e:
                db.session.rollback()
                print(f'Error adding sample data: {str(e)}')

if __name__ == '__main__':
    init_db()
    app.run(debug=True, host='0.0.0.0', port=5000)
