From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 22 Mar 2016 17:35:46 +0100
Message-ID: <20160322173546.40d24cc2@free-electrons.com>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458663893-13766-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On Tue, 22 Mar 2016 17:24:53 +0100, Stefan Roese wrote:
> This patch adds support for the direct access mode to the Orion SPI
> driver which is used on the Marvell Armada based SoCs. In this direct
> mode, all data written to (or read from) a specifically mapped MBus
> window (linked to one SPI chip-select on one of the SPI controllers)
> will be transferred directly to the SPI bus. Without the need to control
> the SPI registers in between. This can improve the SPI transfer rate in
> such cases.
> 
> Both, direct-read and -write mode are supported. But only the write
> mode has been tested. This mode especially benefits from the SPI direct
> mode, as the data bytes are written head-to-head to the SPI bus,
> without any additional addresses.
> 
> One use-case for this direct write mode is, programming a FPGA bitstream
> image into the FPGA connected to the SPI bus at maximum speed.
> 
> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
> Marvell Armada XP Functional Spec Datasheet.
> 
> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> Cc: Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Mark, sorry for the huge delay for v2 of this direct-access patch.
> I was busy with other tasks in the meantime. And only found now
> the time to address (hopefully all) of your comments.

Thanks for this new version! To be honest, I don't remember all the
discussions that took place on the v1, so maybe I'll just be re-asking
the same question.

Has there been any discussion on whether dynamically adding the MBus
window is a good idea, as opposed to statically defining it in the
board .dts ?

So far, the only driver that was using dynamically allocated MBus is
the PCIe controller driver, because there is no way in advanced to know
the number and memory window requirements of the PCIe devices that will
be connected to the system.

For all other windows (BootROM, crypto SRAM and more recently network
related SRAM), we are using statically allocated windows.

So I'm wondering if we should add this additional DT binding that
describes the necessary information to allow the driver to dynamically
allocate a window, or if we shouldn't rely on a statically allocated
window.

This is really an open discussion, I don't have a very well-defined
opinion on the matter.

Let's Cc: Arnd Bergmann on this question, he has followed the whole
MBus story and might have some interesting insights.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
