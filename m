From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: add bits_per_word_mask check in spi_setup
Date: Fri, 28 Jun 2013 10:51:44 +0800
Message-ID: <CAHG8p1DeSojQ-kn=GZTFpaepUTDCme7NA+=Vani3zK1QePDCzA@mail.gmail.com>
References: <1372287286-12682-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130627113522.GZ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130627113522.GZ27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>> +     if (spi->master->bits_per_word_mask) {
>> +             /* Only 32 bits fit in the mask */
>> +             if (spi->bits_per_word > 32)
>> +                     return -EINVAL;
>> +             if (!(spi->master->bits_per_word_mask &
>> +                             BIT(spi->bits_per_word - 1)))
>> +                     return -EINVAL;
>> +     }
>
> Thinking about this a bit it might reject a valid transfer - it only
> checks the setting in the SPI device, not the setting in the transfer.
> This means that if the transfer overrides an unsuitable setting in the
> controller then an error will be generated as the fixed setting won't be
> seen.  It's hard to imagine when that would happen without something
> being very confused but still feels better to check the bits per word
> from the first transfer too.

But the API description said that this call would fail if the protocol
driver specifies an option
that the underlying controller or its driver does not support. It's
strange if I request 9 bits per
word in setup successfully while calling it in transfer fail.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
