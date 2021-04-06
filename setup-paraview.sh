sudo yum install -y mesa-libGLU
cd /home/opc
curl -d submit="Download" -d version="v4.4" -d type="binary" -d os="Linux" -d downloadFile="ParaView-4.4.0-Qt4-Linux-64bit.tar.gz" https://www.paraview.org/paraview-downloads/download.php > file.tar.gz
tar -xf file.tar.gz
mv ParaView-4.4.0-Qt4-Linux-64bit ParaView
echo "alias paraview='/home/opc/ParaView/bin/paraview'" >> ~/.bashrc