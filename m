From: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
Subject: RE: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Tue, 11 Jan 2011 18:42:11 +0900
Message-ID: <CA1F4AF27C0D466BA059E4B050FF3360@hacdom.okisemi.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com><20101229064937.GC8172@angua.secretlab.ca><280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com><20110105163835.GD17272@angua.secretlab.ca><46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com> <topcliff-split@mdm.bga.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'David Brownell'" <dbrownell@users.sourceforge.net>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <yong.y.wang@intel.com>,
	<joel.clark@intel.com>, <kok.howg.ewe@intel.com>,
	"Toshiharu Okada" <toshiharu-linux@dsn.okisemi.com>,
	"'Wang, Qi'" <qi.wang@intel.com>
To: "'Milton Miller'" <miltonm@bga.com>,
	"'Grant Likely'" <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Resend
(Previous destination address is broken partly.)

Hi Grant,

On Friday, January 07, 2011 6:22 PM, Milton Miller wrote:
> follow mfd_add_devices into drivers/mfd/mfd-core.c
I have also seen mfd-core.c.
However, I couldn't clear my question.

Q1. It seems platform_device is not used in your example. 
	Does need "platform_device" ?
Q2. How detect pch_spi channel dynamically ?

I want to catch your saying correctly.
Could you give me more information ?

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.
