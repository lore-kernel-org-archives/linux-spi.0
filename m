From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] Clear control
	bits in drivers/spi/spi_bfin5xx.c as necessary
Date: Tue, 19 Jan 2010 10:46:38 -0700
Message-ID: <fa686aa41001190946w26ab35b5j8699df358d66c46d@mail.gmail.com>
References: <DA80C3E6C10BE94E8FCACEB239C2FEE46645317E77@EXVS01.olin.edu>
	<8bd0f97a0912180514k42f32162jc850f4b4abbc3f7a@mail.gmail.com>
	<8bd0f97a0912180934s3d2c70b7uf65d09dc016c1faa@mail.gmail.com>
	<fa686aa41001190812l28cf29fs5471c1022d25deee@mail.gmail.com>
	<8bd0f97a1001190929w78624e95pa3f32e5147c2617e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>,
	James Getzendanner <James.Getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a1001190929w78624e95pa3f32e5147c2617e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 19, 2010 at 10:29 AM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> On Tue, Jan 19, 2010 at 11:12, Grant Likely wrote:
>> On Fri, Dec 18, 2009 at 10:34 AM, Mike Frysinger wrote:
>>> On Fri, Dec 18, 2009 at 08:14, Mike Frysinger wrote:
>>>> On Fri, Dec 18, 2009 at 02:29, James Getzendanner wrote:
>>>>> From: Andy Getzendanner <james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>
>>>>>=A0The patch also modifies bfin_spi_setup() to
>>>>> set/clear the SIZE bit as appropriate.
>>>>
>>>> ok, but this isnt the place to do it. =A0the size can be changed on a
>>>> per-transfer basis. =A0i have a patch locally to unify the transfer si=
ze
>>>> logic and i'll include this fix in the process.
>>>
>>> i lied, this isnt necessary. =A0it's already handled in the transfer co=
de.
>>> =A0 =A0cr =3D (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
>>> =A0 =A0cr |=3D (width << 8);
>>> =A0 =A0write_CTRL(drv_data, cr);
>>>
>>> where width is CFG_SPI_WORDSIZE16 or CFG_SPI_WORDSIZE8 as dictated by
>>> the transfer.
>>
>> Mike & James,
>>
>> It's not clear to me from the discussion. =A0What is the status of this
>> patch, is it still needed?
>
> he pointed out valid issues in the Blackfin driver that i have fixed,
> just not with his versions

okay.  I'll drop the patch then.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
