# ---- Configuration ----
INSTALL_DIR=~/MRSD_APP/ReflexxesTypeII
ZIP_URL="http://www.reflexxes.com/software/typeiirml/v1.2.6/files/ReflexxesTypeII.zip"

echo "============================================="
echo "Reflexxes Type II v1.2.6 Installer"
echo "============================================="
echo "This will install Reflexxes to: $INSTALL_DIR"
echo

# Check for required tools
echo "Checking dependencies..."
command -v wget >/dev/null 2>&1 || { echo "Error: wget is required but not installed. Install with: sudo apt install wget"; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "Error: unzip is required but not installed. Install with: sudo apt install unzip"; exit 1; }
command -v make >/dev/null 2>&1 || { echo "Error: make is required but not installed. Install with: sudo apt install build-essential"; exit 1; }

echo "Creating installation directory..."
mkdir -p ~/MRSD_APP
cd ~/MRSD_APP

echo "Downloading Reflexxes Type II v1.2.6..."
if [ ! -f "ReflexxesTypeII.zip" ]; then
    wget "$ZIP_URL"
else
    echo "ReflexxesTypeII.zip already exists, skipping download."
fi

if [ -d "ReflexxesTypeII" ]; then
    echo "Removing old ReflexxesTypeII directory..."
    rm -rf ReflexxesTypeII
fi

echo "Extracting ReflexxesTypeII.zip..."
unzip -q ReflexxesTypeII.zip

echo "Fixing Makefile debug flag typo (-gddb to -ggdb)..."
find ReflexxesTypeII/Linux -type f -name 'Makefile*' -exec sed -i 's/-gddb/-ggdb/g' {} +

echo "Building Reflexxes library for 64-bit Linux..."
cd ReflexxesTypeII/Linux
make clean64 all64

echo "============================================="
echo "Installation completed successfully!"
echo "============================================="
echo "Libraries installed to:"
echo "  $INSTALL_DIR/Linux/x64/release/lib/"
echo "  $INSTALL_DIR/Linux/x64/debug/lib/"
echo
echo "Sample applications available in:"
echo "  $INSTALL_DIR/Linux/x64/release/bin/"
echo
echo "Test installation by running:"
echo "  $INSTALL_DIR/Linux/x64/release/bin/static/01_RMLPositionSampleApplication"