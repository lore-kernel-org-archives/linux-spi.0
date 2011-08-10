From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 0/6] spi/spi-pl022 fixes
Date: Wed, 10 Aug 2011 09:25:48 +0530
Message-ID: <4E420144.4010001@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Bhavna YADAV <bhavna.yadav@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
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

On 08/10/2011 01:40 AM, Linus Walleij wrote:
> On Tue, Aug 9, 2011 at 1:05 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> This patchset mainly covers following fixes:
>> - formatting related issues
>> - Passing GFP_NOWAIT for sg allocation from tasklet
>> - Fixing calculate_effective_freq() routine
>> - Allocate/free DMA channels as and when required.
> 
> Excellent work Viresh, apart from the small comment on 4/6
> they all look good.
> 
> I also tested them all on the U300, works perfectly.
> 
> Please fixup 4/6 and respin with my:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for testing.

> 
> So that Grant can pick them up.
> 
>> I have rebased them on linux-next/master over following patch:
>>
>> commit 9be355da3bae9feb09cdaf80c3ab560f1f0172cb
>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date:   Tue Aug 9 13:30:19 2011 +1000
>>
>>    Add linux-next specific files for 20110809
> 
> They all work perfectly well on top of v3.1-rc1, please use
> mainline kernel tags as patch base if you can.
> 

Sure, can take care of this. But i have a doubt here,
What if a patch on the same driver is applied after kernel tag.
Shouldn't i rebase my patches on the latest commit available.

-- 
viresh
