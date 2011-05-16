From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH resend] spi/amba-pl022: work in polling or interrupt
	mode if pl022_dma_probe fails
Date: Mon, 16 May 2011 22:26:09 +0100
Message-ID: <20110516212609.GI13659@n2100.arm.linux.org.uk>
References: <052261410dd8d224fc199518e646abf80bfa7d4c.1305518921.git.viresh.kumar@st.com>
	<20110516110438.GP30539@n2100.arm.linux.org.uk>
	<4DD10A03.2090204@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Armando VISCONTI <armando.visconti@st.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DD10A03.2090204@st.com>
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

On Mon, May 16, 2011 at 04:56:59PM +0530, viresh kumar wrote:
> On 05/16/2011 04:34 PM, Russell King - ARM Linux wrote:
> > On Mon, May 16, 2011 at 09:40:10AM +0530, Viresh Kumar wrote:
> >> > If pl022_dma_probe fails, we can try to transfer data in polling or interrupt
> >> > mode. Also, set platform_info->enable_dma to 0, so that no other code tries to
> >> > use dma.
> >> > 
> >> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> >> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Shouldn't this go via the SPI people rather than my tree?
> 
> This can, but i have seen amba drivers patches going through your
> drivers branch, so sent to tracker.

Yes, because I authored quite a few primecell drivers, and I continue
to maintain those drivers.  The SPI driver is not one of those though.

> Should i get them through spi-devel??

Yes please.
