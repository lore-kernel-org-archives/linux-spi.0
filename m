From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 0/9] spi: bcm2835aux: bug fixes and improvements
Date: Sun, 24 Feb 2019 20:22:27 +0100 (CET)
Message-ID: <1294540802.93488.1551036147867@email.ionos.de>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224125440.16117-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Martin,

> kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org hat am 24. Februar 2019 um 13:54 geschrieben:
> 
> 
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Set of patches improving the spi-bcm2835aux driver and fixing
> a data read corruption bug.
> 
> The main motivation is a rare data corruption fix that is mostly
> observed in polling mode first reported by Hubert Denkmair.
> 
> So this patchset first implements a means to control the parameters
> of when polling mode is used via module parameters and exports
> the corresponding statistics.
> 
> As stated in original patch the driver does not support native CS.
> But when cs-gpios is not configured in the dt (so a buggy dt) it is
> still working with a lot of limitations, but the driver does not report
> this fact.
> 
> So this patchset adds reporting and allows for a single native CS
> (with limited functionality) to continue working with a buggy DT.
> One question here remains: do we need to legacy support DTs
> that are not following specs in the first place?
> 
> Then there is the real fix for the data-corruption which is split
> into 3 parts: some code cleanup with code reuse, removing "dangerous"
> fifo read (possibly introducing fifo data corruption) and safe fifo read
> 
> Finally we remove some dead code.
> 
> Martin Sperl (9):
>   spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
>   spi: bcm2835aux: warn in dmesg that native cs is not really supported
>   spi: bcm2835aux: setup gpio-cs to output and correct level during
>     setup
>   spi: bcm2835aux: add driver specific stats to debugfs
>   spi: bcm2835aux: make the polling duration limits configurable
>   spi: bcm2835aux: unifying code between polling and interrupt driven
>     code
>   spi: bcm2835aux: remove dangerous uncontrolled read of fifo
>   spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
>   spi: bcm2835aux: remove dead code
> 

i consider patch 7 and 8 as possible stable candidates. How about rearranging this series that these patches comes first and could be backported?
