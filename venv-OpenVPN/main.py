from diagrams import Diagram

from diagrams.aws.compute import EC2


try:
     with Diagram("openvpn_lab", show=False):
          EC2("OpenVPN")
except Exception as error:
     print(error)