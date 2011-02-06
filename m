From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v7] spi: New driver for Altera SPI
Date: Sun, 06 Feb 2011 21:23:22 +0100
Message-ID: <87aai8zzd1.fsf@macbook.be.48ers.dk>
References: <20110203173430.GC6180@angua.secretlab.ca>
	<1296914523-13740-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org
To: Thomas Chou <thomas@wytron.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296914523-13740-1-git-send-email-thomas@wytron.com.tw> (Thomas
	Chou's message of "Sat, 5 Feb 2011 22:02:03 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>>>>> "Thomas" == Thomas Chou <thomas@wytron.com.tw> writes:

Hi,

 Thomas> +++ b/drivers/spi/Kconfig
 Thomas> @@ -53,6 +53,13 @@ if SPI_MASTER
 
 Thomas>  comment "SPI Master Controller Drivers"
 
 Thomas> +config SPI_ALTERA
 Thomas> +	tristate "Altera SPI Controller"
 Thomas> +	default n

'n' is the default anyway, so no need for this line.

-- 
Bye, Peter Korsgaard
