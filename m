From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Wed, 30 Mar 2016 16:19:16 +0530
Message-ID: <56FBAF2C.9090401@microchip.com>
References: <1458740576-9168-1-git-send-email-purna.mandal@microchip.com>
 <1458740576-9168-2-git-send-email-purna.mandal@microchip.com>
 <20160328192629.GG2350@sirena.org.uk> <56FA6EE1.3000405@microchip.com>
 <20160329162501.GP2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>,
	Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160329162501.GP2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2016 09:55 PM, Mark Brown wrote:

> On Tue, Mar 29, 2016 at 05:32:41PM +0530, Purna Chandra Mandal wrote:
>
>> It is required for MMC-over-SPI support. Linux MMC_SPI driver sometimes
>> (depending on some logic) want chip-select to be kept enabled (using
>> transfer.cs_change) even at the end of SPI message so that following
>> message(s) can also be made part of the running MMC transaction.
>> In this case if there is any error (and in some other cases as well)
> If your hardware doesn't support per-/CS setup then your driver needs to
> record whatever is configured via setup() and apply it later.

PIC32 SPI controller supports one /CS per instance. So per-/CS specific
logic might not be required.

>> MMC_SPI will have to terminate on-going MMC transactions and it is
>> done by calling setup(). It is assumed that setup() will always leave
>> the chip-select deactivated.
> No, this is just completely broken - that's quite simply not what
> setup() does.  See spi-summary.  There is *no* code in the core that
> terminates ongoing transfers as a result of calling setup(), if that's
> happening it's a result of triggering error handling.

Description of spi_setup() in spi.c clearly mentions that "When this
function returns, the spi device is deselected" and this is only
possible if (at least) chip-select is deactivated.

So based on spi-summary and spi_setup() description, except chip-select,
all other settings has to be recorded and applied later when device is
selected and data is transferred to or from the device.

Keeping this in mind I'll just retain cs-deselect logic in setup() and
apply the recorded setting in prepare_message() callback, if and when required.

>> Best thing I can add is wait for unprepare_message() before calling
>> cleanup().
> The cleanup() function is for deallocating dynamically allocated data,
> it will be called by the core.

ack.

>> If you could suggest better alternative that will be great.
> If you want to change the chip select you need to use the normal
> interfaces for changing the chip select via message processing.

ack.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
