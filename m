From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Wed, 24 Feb 2010 13:39:59 -0700
Message-ID: <fa686aa41002241239v3f3cb18er33bc51d90027fd1d@mail.gmail.com>
References: <20100217191513.52392dd6.eschwab@online.de>
	<20100217191709.2fd1028c.eschwab@online.de>
	<8bd0f97a1002171103g3e08ee02pf761866f3c57f391@mail.gmail.com>
	<fa686aa41002171206o6cbb7477r7f427ef7be0e8450@mail.gmail.com>
	<8bd0f97a1002171219y78c67661o4e1b03c92e2793d0@mail.gmail.com>
	<fa686aa41002171307p694a737ax426dcf26fb547280@mail.gmail.com>
	<8bd0f97a1002171341ja37d5c7nb0040ec5058e95fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a1002171341ja37d5c7nb0040ec5058e95fb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 17, 2010 at 2:41 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> On Wed, Feb 17, 2010 at 16:07, Grant Likely wrote:
>> Also, even if I agreed with the premise that a cookie is needed for
>> deciding who can use the bus when locked, it is still a good idea to
>> use a different API when working with a locked bus. =A0Locking issues
>> are subtle, and driver authors *must understand what they are doing*.
>> Using a different API for talking to a locked bus is one of the things
>> that makes absolute sense to make sure that drivers know which regions
>> have the bus locked, and which do not.
>
> these sort of statements are always made yet it doesnt seem to prevent
> bugs. =A0of course people *should know what they're doing*, but
> *reality* is that people make mistakes and bugs get merged all the
> time. =A0a little proactive protection goes a long way. =A0i dont think
> adding a cookie would increase overhead all that much.

Heh.  Alright.  Then I think I'd like to see a follow-on patch that
adds the cookie checking so that it can be reviewed independently of
all the locking additions.

Cheers,
g.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
