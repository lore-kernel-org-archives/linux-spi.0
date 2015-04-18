From: Marc Kleine-Budde <mkl-96ES3uSCik0DzuLLRaFpuw@public.gmane.org>
Subject: Re: [PATCH v3] spi: bitbang: only toggle bitchanges
Date: Sat, 18 Apr 2015 15:18:49 +0200
Message-ID: <db1d2b9a-730b-40a5-a4f6-091fd3fad0e7@email.android.com>
References: <20150331202306.GX2869@sirena.org.uk> <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de> <20150418120926.GL26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418120926.GL26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On April 18, 2015 2:09:26 PM GMT+02:00, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>On Mon, Apr 13, 2015 at 12:59:30PM +0200, Michael Grzeschik wrote:
>> The current implementation of bitbang_txrx_be_cpha0 and
>> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
>> unnecessary calls into the gpiolib when the level of the GPIO
>actually
>> has not to be changed.
>> 
>> This patch changes the routines to remember the last GPIO level
>> and only calls setmosi if an change has to be made. This
>> way it improves the transfer throughput.
>
>Do you have any benchmarking or anything showing that this offers a
>practical benefit?  Generally a bitbanging system would be using memory
>mapped GPIOs for the bus so we're talking about replacing a memory
>access with some shifts and logic operations here and while I can
>believe that something that runs in cache is going to be an overall win
>over going out to a device it's not quite so clear cut as it could be.

IIRC we had a reduction of about 30% when programming an FPGA via SPI. But Michael can give you the exact numbers. 

Marc
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
