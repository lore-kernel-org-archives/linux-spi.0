From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 15:31:42 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "pratyush.anand@st.com" <pratyush.anand@st.com>,
	"rajeev-dlh.kumar@st.com" <rajeev-dlh.kumar@st.com>,
	"bhavna.yadav@st.com" <bhavna.yadav@st.com>,
	"bhupesh.sharma@st.com" <bhupesh.sharma@st.com>,
	"armando.visconti@st.com" <armando.visconti@st.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"vipin.kumar@st.com" <vipin.kumar@st.com>,
	"shiraz.hashim@st.com" <shiraz.hashim@st.com>,
	"Amit.VIRDI@st.com" <Amit.VIRDI@st.com>,
	"vipulkumar.samar@st.com" <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"deepak.sikri@st.com" <deepak.sikri@st.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Williams,
	Dan J" <dan.j.williams@intel.com>, "
To: "viresh.kumar@st.com" <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E424F7B.2000800@st.com>
Content-Language: en-US
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

On Wed, 2011-08-10 at 14:59 +0530, viresh kumar wrote:
> On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
> >> > They must be allocated when they are required and must be freed after we are
> >> > done with transfers. So that they can be used by other users.
> > Which DMA engine driver requires this?
> > 
> 
> dw_dmac.c
> 
> > Normally, when we have DMA engine drivers with multiple request signals,
> > the slave peripheral side publishes several virtual channels which are
> > claimed by the peripheral drivers.  This (amongst other things) allows
> > the peripheral drivers to hold claim to one of the virtual channels
> > all the time that it's required.
> 
> If users of DMA expect DMA engine drivers to work this way, then we should
> have this mentioned clearly in DMA slave documentation.
> 
> @Dan/Vinod: What do you say?
I would agree on both counts :)

In some cases it does make sense to hold the channel for the lifetime
like uart or where the channel has been tied to an interface by SoC
designer.
But in some cases like dw_dmac it seems you can assign channels
dynamically to each usage, and runtime allocation ensures we have best
utilization.
So i would argue that there is no "one size fits all" here, if you can
manage channels dynamically and utilize more efficiently then go ahead,
but if you cant (h/w and usage constraint) then you should not be forced
to do so.

On DMA Engine API, it doesn't force for any of the above. You are free
to choose based on the usage and capability

And on your patch, are you able to dynamically assign the channels for
platform? What is the intended usage? (as Russell articulated it is bad
to dynamically assign channel for something like uart)

-- 
~Vinod
