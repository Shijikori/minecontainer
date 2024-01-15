# A Very Bad and Basic Minecraft Container

## Warnings

When it comes to operations, this container is built with the assumption that the host system will be a Linux system. As such, file ownership and permissions are all built for Linux file systems in mind. Usage of this container on a Windows host has not been tested and is not recommended.

## Variables

### Regular operations variables

| Name | Example value | Required | Explanation |
| - | - | - | - |
| VERSION | `1.20.1` | `Yes` | Minecraft version |
| TYPE | `FORGE` | `Yes` | The type of server, capitalized. Actually only matters if the server is `Forge` but recommended to be set anyway. |
| FORGE\_VERSION | `47.2.20` | `No` | Forge version, required if server type is Forge (can be ignored if server is of older versions). |
| OPS | `Steve` | `No` | Minecraft username of the operator of the server. |
| JVM\_ARGS\_FILE | `jvm-args.txt` | `Yes` | Path to the text file containing JVM arguments (inside of data folder/volume) |
| SERVER\_JAR | `server.jar` | `Yes` | Path to the server jar file. Should be specified in most cases. Can be ignored for modern Forge version. |
| ICON\_URL | `http://image.com/cheese.png` | `No` | URL to a PNG icon file within specifications for Minecraft server icons. |
| SERVER\_ADDR | `myserver.ddns.net` | `No` | Address of the server, can be an IP address. This address must be accessible on the Internet. It is used with mcstatus.io API to check the status of the server. If you do not wish to make use of the status and health check in the server, do not specify this value. |
| EULA | `TRUE` | `No` | Agrees to the EULA. Defaults to TRUE because I am lazy. |
| UID | `1000` | `No` | Sets the UID for operations and file ownership. |
| GID | `1000` | `No` | Sets the GID for operations and file ownership. |

### Installation variables

General Recommendation : Installation should be executed with run and not as a Swarm service or Compose service.

| NAME | Example Value | Required | Explanation |
| - | - | - | - |
| INSTALL | `TRUE` | `Yes` | Specifies the container should install the server and not run it. This is only for Forge servers. |
| INSTALLER | `forge-installer.jar` | `Yes` | Specifies the installer jar. Assuming the specified jar is found in the data volume/folder. |
| UID | `1000` | `No` | Sets the UID for operations and file ownership. |
| GID | `1000` | `No` | Sets the GID for operations and file ownership. |

## Build

### Requirement

Download your preferred JVM (I recommend Temurin from adoptium.net) of the version you need, for Linux x86\_64/amd64. Make sure the JVM home is extracted, the build script does not support extracting.

### Building

Run the following command where the build arg `java` should be the path to your JVM's home.

```bash
docker build --build_args="java=javapath" . -t minecontainer
```

## License

Copyright 2024 Jeremi "Shijikori" Campagna

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

