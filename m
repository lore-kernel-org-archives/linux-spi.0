From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: spidev_test.c: Make transfer
	size suitable for wordsize 32
Date: Tue, 25 May 2010 13:41:15 -0600
Message-ID: <AANLkTinZUXo2fjD6ijdTWfDhom6TF6e0goiXuVUshPxN@mail.gmail.com>
References: <1273828467-4593-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1273828467-4593-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100514122239.GB24394@oksana.dev.rtsoft.ru>
	<AANLkTinWmX39klqQvBPpZY44YdTK3ESb6uu6EomW7fZb@mail.gmail.com>
	<OF066BF1BA.ACBE06A8-ONC125772B.004FB6E4-C125772B.00501681@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF066BF1BA.ACBE06A8-ONC125772B.004FB6E4-C125772B.00501681-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, May 22, 2010 at 8:34 AM, Joakim Tjernlund
<joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org wrote on 2010/05/22 10:39:38:
>>
>> On Fri, May 14, 2010 at 6:22 AM, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>> > On Fri, May 14, 2010 at 11:14:27AM +0200, Joakim Tjernlund wrote:
>> >>
>> >> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
>> >
>> > Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> I don't think I'll apply this one. =A0I know it's just sample code, but
>> it still smells of masking a corner case. =A0If you really want to do
>> this, then I'd suggest adding a runtime switch to change the transfer
>> size.
>
> How so? The current version don't stand a chance to do any ops. with word=
 size 32
> as all transfers has to have a wordsize aligned len. This is not a corner=
 case.

but it also changes the transfer size for 16 and 8 bpw transfers to
something, for lack of a better word, more boring.  I'd rather see a
patch that clamps the transfers size based on the bpw setting.  Bonus
points for a patch that adds the ability to change the transfer size
and/or data from the command line.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
