From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 0/3] davinci: spi: replace existing
	SPI driver
Date: Tue, 29 Jun 2010 15:49:28 -0600
Message-ID: <AANLkTilGDE8xgC3r3gDwchjBVAYMtWFz4HobyxDUtVkR@mail.gmail.com>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTilTTgTchq_w0CktXokOxGX32lmRyPqrTyFI9LCF@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E77EDA9C@dbde02.ent.ti.com>
	<AANLkTikSU105SxoX6m0u0DhDoGQ0047eSGurpivfn74s@mail.gmail.com>
	<AANLkTilT2mZsbgt3fyjEpFheI6U2qNpyW-2ruC7tcvkH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Nori,
	Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTilT2mZsbgt3fyjEpFheI6U2qNpyW-2ruC7tcvkH-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 29, 2010 at 2:01 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Mon, Jun 28, 2010 at 11:27 AM, Grant Likely
> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Mon, Jun 28, 2010 at 10:57 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
>>> Hi Grant,
>>>
>>> On Sun, Jun 27, 2010 at 11:33:13, Grant Likely wrote:
>>>> Any users of the current davinci_spi driver care to comment on this
>>>> series? =A0I'm hesitant to apply a complete replacement to a driver th=
at
>>>> was only added in December without having a lot more information.
>>>
>>> Inside TI, we tested the new driver using SPI flash in DMA, interrupt a=
nd
>>> polled modes and found it to be working fine. Please see:
>>>
>>> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi+G/Ez6ZCGd0@public.gmane.org=
com/msg18139.html
>>> and
>>> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi+G/Ez6ZCGd0@public.gmane.org=
com/msg18198.html
>>>
>>> Other folks have tested it too and are happy with the fixes it bring in:
>>>
>>> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi+G/Ez6ZCGd0@public.gmane.org=
com/msg18184.html
>>>
>>> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi+G/Ez6ZCGd0@public.gmane.org=
com/msg18195.html
>>>
>>> Thanks,
>>> Sekhar
>>
>> Thanks Sekhar. =A0I'll take a look at them when I get back home tomorrow.
>
> Brian, can you please also respin this series and add descriptions to
> the patches. =A0You wrote a description if your cover email, but the
> details need to be in the specific patches so that it is available in
> the commit object. =A0You can also add the Acked-by: or Tested-by: lines
> for the people who have reviewed & tested and indicated that the
> patches are okay.

Alternately, you can also just reply to each patch with the commit
text and acked-by/tested-by tags.  I can assemble it when I commit
them to my tree.

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
