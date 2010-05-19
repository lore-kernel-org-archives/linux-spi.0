From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
Date: Wed, 19 May 2010 12:56:25 +0200
Message-ID: <AANLkTinbLmmugmi1-KdzHZAL0Zz3omQ0VaArumuwjwaR@mail.gmail.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
	<63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
	<fa686aa41002030948g6359ef3o4c3a7b265490b93f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41002030948g6359ef3o4c3a7b265490b93f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/2/3 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:

>> As some sort of maintainer of this file I have signed it off and put
>> it into Russells
>> patch tracker for inclusion, OK? See;
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D5893/1
>
> I'm actively maintaining SPI now. =A0In general, I'd prefer SPI patches
> to go through the SPI tree, unless there are commit ordering issues
> with arch code.

Is this working out? The patches in patchwork will be in for the merge
window, no?

Not that I feel it's a disaster if they don't get in now, it's mainly
that I want to
know if I can help out in some way.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
