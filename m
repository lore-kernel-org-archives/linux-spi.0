From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/15]drivers:spi:dw_spi.c Typo change diable to disable.
Date: Fri, 31 Dec 2010 06:17:58 -0800
Message-ID: <4D1DE616.7010105__36095.8496145487$1293805137$gmane$org@gmail.com>
References: <1293750484-1161-1-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-2-git-send-email-justinmattock@gmail.com>
	<20101231064515.GC3733@angua.secretlab.ca>
	<4D1D7DAE.7060504@gmail.com> <20101231091136.GC1886@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org,
	linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	li
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101231091136.GC1886@bicker>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/31/2010 01:11 AM, Dan Carpenter wrote:
> On Thu, Dec 30, 2010 at 10:52:30PM -0800, Justin P. Mattock wrote:
>> On 12/30/2010 10:45 PM, Grant Likely wrote:
>>> On Thu, Dec 30, 2010 at 03:07:51PM -0800, Justin P. Mattock wrote:
>>>> The below patch fixes a typo "diable" to "disable". Please let me know if this
>>>> is correct or not.
>>>>
>>>> Signed-off-by: Justin P. Mattock<justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> applied, thanks.
>>>
>>> g.
>>
>> ahh.. thanks.. just cleared up the left out diabled that I had
>> thought I forgotten(ended up separating comments and code and
>> forgot)
>
> This is really just defensiveness and random grumbling and grumpiness on
> my part, but one reason I may have missed the first patch is because
> your subject lines are crap.
>
> Wrong:  [PATCH 02/15]drivers:spi:dw_spi.c Typo change diable to disable.
>
> Right:  [PATCH 02/15] spi/dw_spi: Typo change diable to disable
>
> regards,
> dan carpenter
>

alright.. so having the backlash is alright for the subject

Thanks for the pointer on this..

Justin P. Mattock

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
