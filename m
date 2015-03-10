From: Adrian Remonda <adrianremonda@gmail.com>
Subject: [PATCHv2 0/4] spi: spidev_test: Added functionalities
Date: Tue, 10 Mar 2015 16:12:29 -0400
Message-ID: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda@gmail.com, broonie@kernel.org, corbet@lwn.net,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is the corrected version of a patch series that adds functionalities 
to the spidev_test tool found in Documentation/spi/spidev_test.c.

- Cleaned hexadecimal dump
- Added verbose mode to see the transmitting sequence
- Added input buffer from the terminal. Now it is possible to send
  string and hexadecimal data as an input parameter:

  Example that shows verbose mode and a sending sequence:

  root@microZed:~# ./a.out -D /dev/spidev32766.1 -p "\x23ab1" -v
  spi mode: 0x0
  bits per word: 8
  max speed: 500000 Hz (500 KHz)
  TX | 23 61 62 31 __ __ __ __  | #ab1
  RX | FF FF FF FF __ __ __ __  | ....

Adrian Remonda (4):
  Cleaned hexadecimal dump
  Added verbose output
  Added input buffer from the terminal
  Moved spidev_tool.c to tools/spi

 Documentation/spi/spidev_test.c |  243 ------------------------------
 tools/spi/spidev_test.c         |  318 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+), 243 deletions(-)
 delete mode 100644 Documentation/spi/spidev_test.c
 create mode 100644 tools/spi/spidev_test.c

-- 
1.7.10.4

