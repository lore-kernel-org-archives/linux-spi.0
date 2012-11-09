From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: sequence compatible strings as per preference
Date: Fri, 09 Nov 2012 10:28:38 -0700
Message-ID: <509D3D46.7060102@wwwdotorg.org>
References: <1352452052-13823-1-git-send-email-ldewangan@nvidia.com>
	<509D37B8.8020606@wwwdotorg.org>
	<20121109171008.GX23807@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121109171008.GX23807-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/09/2012 10:10 AM, Mark Brown wrote:
> On Fri, Nov 09, 2012 at 10:04:56AM -0700, Stephen Warren wrote:
> 
>> However just FYI, it should not be necessary for correctness; The
>> DT matching order is supposed to be driven purely by the order of
>> the compatible values in the DT now, and not affected by the
>> order of values in the table. (This wasn't always the case, but
>> was a bug that was fixed IIRC by Thierry Reding).
> 
> I guess the driver is being used backported in older kernels which
> don't have that fix?

That sounds likely. Laxman, it'd be a good idea to track down the fix
to the DT matching code and backport it, so that hard-to debug issues
aren't caused by the lack of that patch!

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
