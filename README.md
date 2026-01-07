# 📦 Inventory Management Application

A web-based inventory management system built with Flask and SQLite. This application allows users to track, manage, and monitor inventory items with a clean and intuitive interface.

## 🌟 Features

- **Dashboard**: View inventory statistics at a glance
  - Total number of products
  - Total items in stock
  - Total inventory value
- **CRUD Operations**: 
  - Create new inventory items
  - Read and view all items in a table
  - Update existing items
  - Delete items with confirmation
- **Search Functionality**: Search items by name, category, or description
- **Low Stock Alerts**: Visual indicators for items with low quantity
- **Responsive Design**: Works on desktop and mobile devices
- **Sample Data**: Pre-loaded with sample inventory items for demonstration

## 📋 Prerequisites

- Python 3.7 or higher
- pip (Python package manager)

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/IKRAM-ULLAH-4/Inventry-Management-App.git
   cd Inventry-Management-App
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

## 💻 Usage

1. **Run the application**
   ```bash
   python app.py
   ```

2. **Access the application**
   - Open your web browser and navigate to: `http://localhost:5000`
   - Or access from other devices on the same network: `http://YOUR_IP:5000`

3. **Using the application**
   - **Home Page**: View all inventory items and statistics
   - **Add Item**: Click "Add New Item" to create a new inventory entry
   - **Edit Item**: Click the "Edit" button on any item to modify it
   - **Delete Item**: Click the "Delete" button and confirm to remove an item
   - **Search**: Use the search bar in the navigation to find specific items

## 📁 Project Structure

```
Inventry-Management-App/
├── app.py                 # Main application file with Flask routes
├── requirements.txt       # Python dependencies
├── README.md             # Project documentation
├── templates/            # HTML templates
│   ├── base.html        # Base template with navigation
│   ├── index.html       # Home/Dashboard page
│   ├── add_item.html    # Add new item form
│   ├── edit_item.html   # Edit item form
│   └── search.html      # Search results page
├── static/              # Static files (CSS, JS, images)
│   └── css/
│       └── style.css    # Application styles
└── instance/            # Created automatically
    └── inventory.db     # SQLite database (auto-generated)
```

## 🗄️ Database Schema

The application uses a single table `inventory_item` with the following fields:

- `id`: Integer, Primary Key
- `name`: String(100), Required - Item name
- `category`: String(50), Required - Item category
- `quantity`: Integer, Required - Stock quantity
- `price`: Float, Required - Item price
- `description`: Text, Optional - Item description
- `date_added`: DateTime - Timestamp when item was created
- `last_updated`: DateTime - Timestamp when item was last modified

## 🎨 Features Demonstration

### Dashboard
- View summary cards showing:
  - Total number of product types
  - Total quantity of all items
  - Total value of inventory
- Complete table of all inventory items

### Item Management
- Add new items with name, category, quantity, price, and description
- Edit existing items with pre-filled forms
- Delete items with confirmation dialog
- Automatic timestamp tracking

### Search
- Real-time search across item names, categories, and descriptions
- Results displayed in a table format

## 🛠️ Technologies Used

- **Backend**: Python Flask 3.0.0
- **Database**: SQLite with Flask-SQLAlchemy
- **Frontend**: HTML5, CSS3 (no JavaScript framework)
- **Styling**: Custom CSS with responsive design

## 📝 Sample Data

The application comes with 5 pre-loaded sample items:
1. Laptop (Electronics)
2. Wireless Mouse (Electronics)
3. Office Chair (Furniture)
4. Notebook (Stationery)
5. Desk Lamp (Furniture)

## 🔒 Security Notes

For production deployment, remember to:
- Change the `SECRET_KEY` in `app.py`
- Use a production-grade database (PostgreSQL, MySQL)
- Set `debug=False` in `app.run()`
- Use environment variables for sensitive data
- Implement user authentication if needed

## 🐛 Troubleshooting

**Database Issues**
- If you encounter database errors, delete the `inventory.db` file and restart the application. It will create a fresh database with sample data.

**Port Already in Use**
- If port 5000 is already in use, modify the port in `app.py`:
  ```python
  app.run(debug=True, host='0.0.0.0', port=8080)
  ```

**Dependencies Not Installing**
- Make sure you have Python 3.7+ installed
- Try upgrading pip: `pip install --upgrade pip`

## 👨‍💻 Author

IKRAM ULLAH

## 📄 License

This project is open source and available for educational purposes.

## 🎓 Lab Demonstration Notes

This application is ready for final lab demonstration and includes:
- ✅ Complete CRUD functionality
- ✅ Database integration with SQLite
- ✅ Professional UI/UX design
- ✅ Search functionality
- ✅ Data validation and error handling
- ✅ Sample data for immediate demonstration
- ✅ Responsive design for various screen sizes
- ✅ Clear documentation and setup instructions