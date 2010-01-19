From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Memory-mapped Dwsignware SPI driver
Date: Tue, 19 Jan 2010 08:21:14 -0700
Message-ID: <fa686aa41001190721q39fc359ay319aa25589202d3c@mail.gmail.com>
References: <20100118164921.23527.74770.stgit@station520.octasic.com>
	<fa686aa41001180921u3919c3e4u3711097218cbfa7e@mail.gmail.com>
	<4B54A519.7030606@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4B54A519.7030606-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 18, 2010 at 11:14 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
>
>
> Grant Likely wrote:
>>
>> On Mon, Jan 18, 2010 at 9:50 AM, Jean-Hugues Deschenes
>> <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
>> The MMIO patch looks non-orthogonal to the PCI stuff so I don't
>> understand why a choice/endchoice is being used here. =A0Is there any
>> reason that both bus attachments cannot be compiled as modules at the
>> same time?
>>
>
> Aside from the fact that no chip would realistically have both at the same
> time, nope. I'll lift the restriction.

Thanks.  Making them both selectable improves the build test coverage
for things like allmodconfig and allyesconfig.

g.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
