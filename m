From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace
	existing driver
Date: Fri, 20 Aug 2010 11:19:12 -0600
Message-ID: <AANLkTi=YuaPSeQrKbzvMgdux-u5H_puA-p-iqCYjbwPp@mail.gmail.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTim-FB6YrGSTmDQhmnS+Qw-dGm7D-pH7iCzy0-Td@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7ED0A13@dbde02.ent.ti.com>
	<201008201406.33473.caglarakyuz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, "Nori,
	Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201008201406.33473.caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 20, 2010 at 5:06 AM, Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Monday 02 August 2010 06:53:16 pm Nori, Sekhar wrote:
>> Hi Brian,
>>
>> On Mon, Aug 02, 2010 at 19:40:29, Brian Niebuhr wrote:
>> > Grant -
>> >
>> >
>> > =A0For my part, I've already sunk way more time into this than I ever
>> > intended, and I really have no clue how to break this patch down into
>> > smaller patches. =A0I don't really care much if the patch gets accepted
>> > or not - I am just trying to help out all of the other users that are
>> > stuck with a broken driver like I was. =A0Maybe if TI wants to give
>> > their customers a driver that actually works they'll pick it up and do
>> > the rest of the work that's necessary to get it accepted.
>>
>> Thanks for all the work on this so far. We will work on breaking
>> this patch up and getting the fixes accepted upstream.
>>
>
> Is there any improvement on this or anybody is actively working on submit=
ting
> patches?
>
> I'm going to try this driver on DaVinci DM6446 and OMAP L-138 with differ=
ent
> peripherals. If nobody is expected to submit something soon, then I can w=
ork
> on preparing incremental patches while working with the driver. I can sta=
rt
> sending patches next week or so.
>
> Best Regards,
> Caglar

Thanks Caglar for picking up this work.  I look forward to seeing the
patches.  Let me know if you need any help with getting them in shape
for merging.

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
