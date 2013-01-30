From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Make spi-fsl-spi usable in cpu mode
	outside of FSL SOC environments and add a grlib variant normally
	running on sparc
Date: Wed, 30 Jan 2013 12:04:38 +0100
Message-ID: <5108FE46.1030102@gaisler.com>
References: <1356711368-10437-1-git-send-email-andreas@gaisler.com>
	<5108F031.1010005@gaisler.com>
	<20130130103645.GB6229@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130130103645.GB6229-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2013-01-30 11:36, Mark Brown wrote:
> On Wed, Jan 30, 2013 at 11:04:33AM +0100, Andreas Larsson wrote:
>> On 2012-12-28 17:16, Andreas Larsson wrote:
>
>>> This makes the cpu mode of the driver available outside of an FSL SOC
>>> and even powerpc environment. This is accomplished by putting things
>>> regarding fsl specific code and to cpm specific code within ifdefs.
>
>> Any comments anyone?
>
>> This patch takes "Approach A" discussed and supported in
>> http://sourceforge.net/mailarchive/message.php?msg_id=30131080
>
> I don't seem to have been CCed on the patch...

No, but I thought it might be useful to get you in the loop given the 
recent maintainerhood status change proposal.

You can find the patch at https://lkml.org/lkml/2012/12/28/83 or 
http://sourceforge.net/mailarchive/message.php?msg_id=30280254

If you would like I'll resend the patch adding you to the CC list.

Cheers,
Andreas Larsson


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
