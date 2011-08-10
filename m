From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 11:29:32 +0100
Message-ID: <20110810102932.GH1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
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
	"vipin.kumar@st.com" <vipin.kumar@st.com>,
	"shiraz.hashim@st.com" <shiraz.hashim@st.com>,
	"Amit.VIRDI@st.com" <Amit.VIRDI@st.com>,
	"vipulkumar.samar@st.com" <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"deepak.sikri@st.com" <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>, "Williams,
	Dan J" <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-ke
To: "Koul, Vinod" <vinod.koul@intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
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

On Wed, Aug 10, 2011 at 03:31:42PM +0530, Koul, Vinod wrote:
> I would agree on both counts :)
> 
> In some cases it does make sense to hold the channel for the lifetime
> like uart or where the channel has been tied to an interface by SoC
> designer.
> But in some cases like dw_dmac it seems you can assign channels
> dynamically to each usage, and runtime allocation ensures we have best
> utilization.

If dw_dmac can assign channels dynamically at runtime to request signals,
it is no different from pl08x, where we have essentially the same
capability, and we do have the virtual channel support.

The virtual channel support is far more flexible than picking a physical
channel at allocation time, because it means you can reassign the
virtual channel at any point when a transfer is not in progress.  Plus
it means that you don't have to keep doing the channel allocation,
configuration and freeing on every transfer which would be hugely
wasteful.  Not to mention that it burdens peripheral drivers with
unnecessary additional complexity - which means additional bugs.

I would encourage all DMA engine drivers which have this capability to
switch to a virtual channel setup to ensure maximum interoperability
between different peripheral drivers.

I'd also suggest that we probably want to make the virtual layer a
library for DMA engine implementations to use.  We really don't want
every DMA engine implementation re-creating that support time and time
again.  I'll look into pulling the virtual channel stuff out of PL08x
over the next month or so.
