From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH - v2] spi: davinci: add OF support for the spi controller
Date: Wed, 19 Dec 2012 09:29:20 -0500
Message-ID: <50D1CF40.8000203@ti.com>
References: <1355260839-29865-1-git-send-email-m-karicheri2@ti.com>
	<20121215002758.14D223E0BEC@localhost>
	<20121219131850.E421B3E0AD7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	linux-keystone-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121219131850.E421B3E0AD7@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/19/2012 08:18 AM, Grant Likely wrote:
> On Sat, 15 Dec 2012 00:27:58 +0000, Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>  wrote:
>> On Tue, 11 Dec 2012 16:20:39 -0500, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>  wrote:
>>> This adds OF support to DaVinci SPI controller to configure platform
>>> data through device bindings. Also replaces clk_enable() with
>>> of clk_prepare_enable() as well as clk_disable() with
>>> clk_disable_unprepare().
>>>
>>> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
>>> Reviewed-by : Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Applied, thanks.
>>
>> I did remove the OF_ALIAS_N property though. I know the COMPATIBLE one
>> uses it, but it is actually kind of redundant since it can also be
>> determined by counting the number of OF_ALIAS_* entries, and having the
>> _N one in there means extra work needs to be done to filter it out.
>>
>> Also, I had to add a #ifndef _LINUX_OF_PRIVATE_H wrapper around the
>> whole header file. This is needed for all header files to protect
>> against multiple includes.
> Ummm.... oops. I replied to the wrong email when applying another patch.
> Sorry for the noise.
>
> But I have applied your patch now. It will appear in linux-next after
> the merge window closes.
>
> g.
>
>
Grant,

Thanks for taking care of this.

Murali

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
