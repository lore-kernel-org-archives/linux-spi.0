From: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Subject: MCP2515 implementation is slow
Date: Tue, 25 Nov 2014 16:19:33 +0000
Message-ID: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Return-path: <linux-can-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Guys,

I have compiled MCP251x.c kernel driver module for Olimex A20-Olinuxino Micro.

The device is working fine for one frame at a time at 500ms. If I send two or more frame at the same time,
CAN is going to bus-off due to overrun errors.
Even if I send one frame at faster rate say, 100ms,results in bus-off.

I am communicating with module with ip commands, cansend & candump.
Also my SPI module is working only at 250K baud, not any other baud.

Any suggestions.

Best Regards,
Pankaj
