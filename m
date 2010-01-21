From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] link dw_spi.o with the kernel
	objects
Date: Thu, 21 Jan 2010 08:56:15 -0700
Message-ID: <fa686aa41001210756n358d5ff2ja9bb93a9b37ce9c1@mail.gmail.com>
References: <20100121153254.18310.27155.stgit@station520.octasic.com>
	<fa686aa41001210741m456d6a07x6184f34bc621cc46@mail.gmail.com>
	<4B5877C1.1080605@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4B5877C1.1080605-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 21, 2010 at 8:50 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Grant Likely wrote:
>>
>> On Thu, Jan 21, 2010 at 8:33 AM, Jean-Hugues Deschenes
>> <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>>>
>>> The bulk of the dw_spi driver is contained in dw_spi.c, which was
>>> statically
>>> linked with the kernel, whether dw_spi_(pci|mmio) was requested to be
>>> built
>>> as a module or not. This patch links dw_spi.o with the kernel module.
>>>
>>
>> Why not just make dw_spi a kernel module on its own?
>>
>
> That would work also.
>
> The reason I see is because dw_spi is useless on its own since it requires a
> "bus interface drver" (dw_spi_(pci|mmio) for the moment)...

... just like all the other common code in the kernel.  :-)

Make it a module.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
