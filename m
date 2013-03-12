From: Girish KS <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 3/5] spi: s3c64xx: Added provision for non-gpio i/o's
Date: Tue, 12 Mar 2013 11:00:48 +0530
Message-ID: <CAKrE-Kedkf6rktJXAT2iRx_csE2YvayA4-nezKtVaK1CRHu+hg@mail.gmail.com>
References: <1360785828-32767-1-git-send-email-ks.giri@samsung.com>
	<1360785828-32767-4-git-send-email-ks.giri@samsung.com>
	<20130302225617.405D23E3209@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130302225617.405D23E3209@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 3, 2013 at 4:26 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Wed, 13 Feb 2013 12:03:46 -0800, Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Currently the drivers supports only the GPIO based i/o pins.
>> But there are Exynos SoC's that use the same controller with
>> dedicated i/o pins.
>>
>> This patch  provides provision to support gpio/dedicated pins.
>> The decision is made by parsing the "gpios" property in the spi
>> node.
>>
>> Signed-off-by: Girish K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> changes in v2:
>>               Removed the gpio quirk. Parse the "gpios" property
>>               to decide whether  gpio / dedicated i/o lines should
>>               be used.
>
> It is perfectly valid to support both at the same time. The gpios
> property can be 'sparse' in that when a gpio is specified, use that for
> the CS control, but use a dedicated line with it is not. Instead of
> doing this it would be better off to switch this driver to use the new
> cs_gpios parsing in driver/spi/spi.c
what i understand from you comment is, you want me to use "cs-gpios"
property for cs control. correct me if i am wrong.
This particular patch is applicable only for MISO/MSIO/CLK. The CS pin
is handled as you mentioned in the next patch of this series.
>
> g.
>
>

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
