From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: spi transfer with zero length
Date: Sat, 16 Feb 2008 23:02:32 +0900 (JST)
Message-ID: <20080216.230232.25478328.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756931AbYBPOCY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi.  Is it legal to use zero for 'len' field of struct spi_transfer?
I mean, len=0, tx_buf=rx_buf=NULL, delay_usecs!=0.

Some SPI devices need slightly long delay before first CLK edge after
CS assertion.  To achieve this, I think inserting using a zero length
transfer before real transfers.  But it seems some drivers do not
handle this case properly.

Is this driver's bug, or we need additional delay field in struct
spi_device for such case?

---
Atsushi Nemoto
