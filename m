From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [Industrial I/O] [0/13] RFC: IIO v3 patchset
Date: Mon, 1 Dec 2008 19:41:36 +0000
Message-ID: <20081201194136.039e201b@lxorguk.ukuu.org.uk>
References: <4933F291.4020001@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, LM, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4933F291.4020001-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> have both functions. The sort of devices we are talking typically
> communicate over I2C or SPI buses though drivers for rs232 devices etc are
> definitely on the cards. Basically we are interested in devices where direct
> memory mapped access is not possible.

We have I2C and SPI drivers so I assume you will use the lower layers of
the stacks to do this ?

> For discussion of why these don't fit within existing subsystems see 
> http://lkml.org/lkml/2008/5/20/135 and the rest of the associated thread.

I don't see much there which says why you can't unify all this in a user
space library.

For RS232/423/.. devices you can go this path if you want (but I would
keep it all in userspace anyway) as you can use a line discipline to sit
on top of the port and provide another interface (eg the way PPP does)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
