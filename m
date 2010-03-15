From: "Centelles, Sylvain" <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Purpose of the  "msg->status"
Date: Mon, 15 Mar 2010 13:06:33 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F4245B4844E@irsmsx501.ger.corp.intel.com>
References: <2A84145621092446B6659B8A0F28E26F4245B483E9@irsmsx501.ger.corp.intel.com>
	<20100315110553.GC11196@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100315110553.GC11196-X57xyCW21FZ5l4KbKkTfamZHpeb/A1Y/@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Baruch,
Thx for your fast answer.
I had seen this piece of code. But if this is the only purpose of the msg->status, then it means it's only used to give return status of the transfer after the completion.
That mean that the only possible value will be an error code or success. The EINPROGRESS (used in the pxa2xx_spi.c for example) will never have a chance to be returned at this place, as any completion will overwrite it. Right? 
That what was confusing me...

Regards,
Sylvain


-----Original Message-----
From: Baruch Siach [mailto:baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org] 
Sent: Monday, March 15, 2010 12:06 PM
To: Centelles, Sylvain
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [spi-devel-general] Purpose of the "msg->status"

Hi Sylvain,

On Mon, Mar 15, 2010 at 10:13:52AM +0000, Centelles, Sylvain wrote:
> I'm currently working on a spi driver for Intel platform, and when reading 
> the various other spi drivers available in the kernel, I saw the msg->status 
> was often updated (EINPROGRESS for example), but could not figure out who 
> checks this status. I would have thought it would be needed to prevent 
> concurrent access for example, but I didn't see anything in the core, nore 
> in any driver. If it's not needed, then I would not like to carry some 
> useless status updates in the driver I'm currently working on.
> Maybe I missed something... So if someone can please give some info on this, it would be great!

See the spi_sync() function in drivers/spi/spi.c. Following is a snippet from 
this function:

        if (status == 0) {
                wait_for_completion(&done);
                status = message->status;
        }
        message->context = NULL;
        return status;

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
