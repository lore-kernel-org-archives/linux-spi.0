From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 22:08:48 -0700
Message-ID: <fa686aa41002162108j1440647br83d5293445d773ef@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<8bd0f97a1002161607m3c748ccegaffb83c42667287a@mail.gmail.com>
	<fa686aa41002161948o31a48fc9kac263b0ac34f1a8d@mail.gmail.com>
	<8bd0f97a1002162034r2d3e397eq12ae0f0df1ae2adb@mail.gmail.com>
	<fa686aa41002162047h4b4c9cdam2133baf3b7d0e27c@mail.gmail.com>
	<8bd0f97a1002162104u5291da69gbff20837f78c9cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a1002162104u5291da69gbff20837f78c9cdf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 10:04 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> On Tue, Feb 16, 2010 at 23:47, Grant Likely wrote:
>> On Tue, Feb 16, 2010 at 9:34 PM, Mike Frysinger wrote:
>>> On Tue, Feb 16, 2010 at 22:48, Grant Likely wrote:
>>>>> there's nothing Blackfin-specific in the implementation of these
>>>>> functions. =A0i think the way we should be handling these is by doing:
>>>>> =A0- remove {lock,unlock}_bus functions from spi_master
>>>>> =A0- move the {lock,unlock}_bus code from spi_bfin5xx.c to spi.c
>>>>> =A0- drop the SPI_BFIN_LOCK Kconfig
>>>>
>>>> Am I missing something. I cannot find any lock related functions in
>>>> the spi code. =A0Is this stuff in mainline?
>>>
>>> i'm proposing what should be done. =A0there is no locking logic anywher=
e atm.
>>
>> Okay, but you're talking about removing functions (lock_bus,
>> unlock_bus) and config values (SPI_BFIN_LOCK) which I cannot find
>> anywhere in mainline.
>
> they were part of the patchsets that were under discussion

Ah, I misunderstood where you were coming from.

g.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
