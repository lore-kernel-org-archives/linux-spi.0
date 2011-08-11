From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Thu, 11 Aug 2011 22:35:55 +0530
Message-ID: <CABb+yY3gi40JyoruEnm06wKJp79_kzjdkwRuGF9vjnUbcb5sOg@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
	<CAKnu2Mo=9wusKrc7DeL9fk-fq3pY1D3WKHXYmo+b9w5GbyzegA@mail.gmail.com>
	<CABb+yY0G_OeVgQs4ySVMQBcBh2q=nUhj+U+=tZG751WT9qRYuA@mail.gmail.com>
	<CAKnu2MptC8HWCNo6W+X9rawn6MCwAe3DB3B5UcHD1tCD9tA2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "pratyush.anand-qxv4g6HH51o@public.gmane.org" <pratyush.anand-qxv4g6HH51o@public.gmane.org>,
	"rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org" <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"bhupesh.sharma-qxv4g6HH51o@public.gmane.org" <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>,
	"shiraz.hashim-qxv4g6HH51o@public.gmane.org" <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	"armando.visconti-qxv4g6HH51o@public.gmane.org" <armando.visconti-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"vipin.kumar-qxv4g6HH51o@public.gmane.org" <vipin.kumar-qxv4g6HH51o@public.gmane.org>, "Koul,
	Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Amit.VIRDI-qxv4g6HH51o@public.gmane.org" <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>,
	"vipulkumar.samar-qxv4g6HH51o@public.gmane.org" <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	"deepak.sikri-qxv4g6HH51o@public.gmane.org" <deepak.sikri-qxv4g6HH51o@public.gmane.org>,
	"bhavna.yadav-qxv4g6HH51o@public.gmane.org" <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, "Williams,
	Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAKnu2MptC8HWCNo6W+X9rawn6MCwAe3DB3B5UcHD1tCD9tA2cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 11, 2011 at 8:18 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 2011/8/11 Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>> Do you have any reason for using device pointer and strings, other
>> than just "because clock and regulator use them" ??
>
> Basically no.

Dear, I am speechless !!
Best of luck.

>>>> Do you propose to implement a string parser in the core ?!
>>>
>>> Yes, the clock and regulator framework already does that.
>>> But it is only used when you cannot pass in a struct device *
>>> directly, like from device tree.
>>
>> Dude, I have utter disrespect for using strings in a case such as
>> expressing requirements.
>
> It's mainly a strcmp(), and it's only comparing to the
> well-established namespace that all devices have anyway,
> due to the way the device model is done.
>
> Basically when binding clocks or regulators it's:
>
> struct device *dev;
> strcmp(map_string, dev_name(dev));
>
> By this time struct device exist of course, since
> it's the device driver calling to get its clock/regulator.
>
> dev_name() comes from <linux/device.h> and basically
> takes the kobject name or an optional initilizer name
> for the device. So the names are pretty static, you don't
> need to parse them, just compare.
I think I know why and how clkdev and regulator use strings.
Here we are talking about dmac possibly expressing 8 parameters
as strings, not just 2.


>> I have already explained how we can easily and in a _better_ way
>> do without them (again see my last reply to Vindo's setup).
>> Tell me 1 reason why using strings, in this case, would be better ?
>
> I have no other reasons than the above.
>
> People like Russell (clkdevice) and Liam Girdwood (regulator)
> who I know are smarter than me and have worked with
> these subsystems for years choose that model, so I trust
> their judgement.
Let me provide you even more 'ammunition'
ASoC and USB-Gadget employs strings too
Though only Regulators, ASoC and CLKDEV(?) really _have-to_
employ strings.
USB-Gadget use them mainly for historical reasons - we can very well
replace that scheme with bit-fields as I propose.

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
