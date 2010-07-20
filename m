From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: make the moved loopback
	test work
Date: Tue, 20 Jul 2010 23:10:02 +0200
Message-ID: <AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
	<812288.2599.qm@web180314.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <812288.2599.qm-4JhmkcZgSkkA0QRgWO9Mevu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/7/20 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:

>> No matter how much I look at it, it seems like
>> all use of this require you to first register
>> *some* device,
>
> OBVIOUSLY. =A0You can't use SPI without a device;
> it's like any other driver framework in Linux.
> What else should you expect???

I didn't expect anything else, it just makes it clear that
the part of my patch registering a dummy device is
not what is being disagreed upon, so this should be OK.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
