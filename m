From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH] OMAP: McSPI: Fix RX DMA transfer path
Date: Mon, 15 Jun 2009 10:58:47 +0530
Message-ID: <005a01c9ed7a$2a5227b0$LocalHost@wipultra793>
References: <> <1244809910-4014-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <linux-omap@vger.kernel.org>,
	"Eero Nurkkala" <ext-eero.nurkkala@nokia.com>
To: "Aaro Koskinen" <aaro.koskinen@nokia.com>,
	<dbrownell@users.sourceforge.net>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

----- Original Message ----- 
From: "Aaro Koskinen" <aaro.koskinen@nokia.com>
Subject: [PATCH] OMAP: McSPI: Fix RX DMA transfer path


> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>
> When data is read through DMA, the last element must be read separately
> through the RX register. It cannot be transferred by the DMA. For further
> details see e.g. OMAP3430 TRM.

Could you provide the section number and the version of TRM you are
referring to.

>
> Without the fix the driver causes extra clocks to be clocked to the
> bus after DMA RX operations. This can cause interesting behaviour with
> some devices.

Could you provide more details on the errors seen i.e is the transfer 
aborted

Thanks
Hemanth

