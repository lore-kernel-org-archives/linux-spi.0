From: Domenico Andreoli <dr.domenico.andreoli@gmail.com>
Subject: [PATCH 0/2] OF: add MMC binding helpers
Date: Thu, 21 Apr 2011 15:16:52 +0200
Message-ID: <20110421131652.GA15155@dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

  in working to add OF support to S3C MMC I discovered that some good
code has been already written for the MMC-over-SPI driver. This is
the first attempt to use it to build a common set of OF bindings for
MMC drivers.

Please tell me whether I'm on a good way or not.

cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://cavokz.wordpress.com/gpgkey/
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
