From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_spi=3A_pxa2xx=5Fsp?=
	=?iso-8859-1?q?i_introduce_chip=09select_gpio_to_simplify_the_comm?=
	=?iso-8859-1?q?on_cases?=
Date: Wed, 10 Sep 2008 23:08:31 -0700
Message-ID: <200809102308.31675.david-b@pacbell.net>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net>
	<48C64EBE.6090003@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48C64EBE.6090003-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 09 September 2008, Jonathan Cameron wrote:
> =

> > =A0- It's probably worth removing support for the SSFRM
> > =A0 =A0mechanism and requiring gpio_cs or (at least as a
> > =A0 =A0transitional scheme) the cs_control() thing.
>
> I disagree strongly with this.
> =

> By all means issue a warning that cs_change will be
> effectively 1 in all cases. However, with many real setups
> this is absolutely fine. Leave getting this right to a
> combination of the board config writers and some good
> documentation!

My logic is as follows:

  (a) it's superfluous given that the pin used for
      SSFRM can be managed as a GPIO;
  (b) it's less capable than managing it as a GPIO,
      examples being lack of SPI_CS_HIGH support
      and broken cs_change;
  (c) given (b) and what you noted, it's error prone;
  (d) given (a-c) it's confusing

In short, removing this mechanism would improve quality
and maintainability.  Needing *more* documentation for
core functionality is a red flag.

Notice I'm not saying it can't (or doesn't) work, within
its constraints (b).  I'm just saying that if it's removed,
the driver will be better and won't lose *ANY* functionality.

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
