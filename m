From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
Date: Wed, 11 May 2011 12:49:42 +0530
Message-ID: <4DCA388E.5060003@st.com>
References: <4DCA0B77.8060700@st.com>
	<20110511071754.GN26703@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dinesh Kumar SHARMA <dinesh.sharma@st.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	Vikas MANOCHA <vikas.manocha@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Jamie Iles <jamie@jamieiles.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110511071754.GN26703@pulham.picochip.com>
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

On 05/11/2011 12:47 PM, Jamie Iles wrote:
> What SPI controller are you using?  I've seen a similar issue with the 
> Synopsys DesignWare SPI controller where the controller manages the chip 
> select itself, and once the FIFO is emptied the CS goes away, but the 
> flash chip requires it to stay high for the whole transaction.  In this 
> case the workaround is to use a GPIO as a chip select and there are 
> other controllers that do the same thing for the same reason (I think 
> that pxa2xx_spi is one of them).

I am using amba pl022 controller and using external gpio's to control
chip select signal. cs is kept low for entire message, but still i am facing
this issue.

-- 
viresh
