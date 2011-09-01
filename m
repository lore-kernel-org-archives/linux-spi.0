From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 0/6] spi/spi-pl022 fixes
Date: Thu, 1 Sep 2011 12:56:05 +0200
Message-ID: <CACRpkdYeq9in+U_tyvb=yVuX2t5TnkUSsO+BozUGVJwZVh+4Ag@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<4E5F58BB.4020205@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Bhavna YADAV <bhavna.yadav@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E5F58BB.4020205@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 1, 2011 at 12:04 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 8/10/2011 2:20 PM, Viresh KUMAR wrote:
>>
>> This patchset mainly covers following fixes:
>> - formatting related issues
>> - Passing GFP_ATOMIC for sg allocation from tasklet
>> - Fixing calculate_effective_freq() routine
>> - Allocate/free DMA channels as and when required.
>>
>
> Grant,
>
> Did you already pushed this patchset?
> There are few concerns on PATCH 6/6 and i am not sure if there are any decisions
> on it.
> @Linus: What do you say?

I agree. Acked-by: Linus Walleij <linus.walleij@linaro.org> for
all except 6/6, it's probably just as possible to keep the channel handle
taken in the driver if we modify the affected DMA driver instead.
This would be better for performance I think.

Thanks,
Linus Walleij
