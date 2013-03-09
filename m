From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: remove unused Tegra platform data header
Date: Sat, 9 Mar 2013 17:21:20 +0800
Message-ID: <CACxGe6uFCLzm2LCtchRxv9uQTNcyxjHQMXEdCTBwOkf5suV2Cw@mail.gmail.com>
References: <1360965830-19795-1-git-send-email-swarren@wwwdotorg.org>
 <1360965830-19795-4-git-send-email-swarren@wwwdotorg.org> <20130302230217.1F9353E32AB@localhost>
 <513A1B82.6060101@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513A1B82.6060101-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 9, 2013 at 1:10 AM, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 3/2/2013 6:02 PM, Grant Likely wrote:
>>
>> On Fri, 15 Feb 2013 15:03:50 -0700, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
>> wrote:
>>>
>>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> The platform data header is no longer used. Delete it.
>>>
>>> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> I like the diffstat for this series. Applied!
>>
>> Thanks,
>> g.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Grant, I was looking to pull these patches. I don't see them in linux-next
> and I
> looked at your repo and didn't see them. Can you give me a pointer?

That is because I haven't pushed them out yet. Initially it was
because the merge window was still open, and then it was because I was
in Hong Kong last week for Linaro Connect. I haven't wanted to push
out my trees until I have a chance to do some build testing which I
will do on Monday.

g.
