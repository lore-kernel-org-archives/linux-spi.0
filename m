From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
Date: Wed, 11 May 2011 08:17:54 +0100
Message-ID: <20110511071754.GN26703@pulham.picochip.com>
References: <4DCA0B77.8060700@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dinesh Kumar SHARMA <dinesh.sharma@st.com>,
	"linus.walleij@stericsson.com" <linus.walleij@stericsson.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spi-devel-general@lists.sourceforge.net,
	Vikas MANOCHA <vikas.manocha@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DCA0B77.8060700@st.com>
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

On Wed, May 11, 2011 at 09:37:19AM +0530, viresh kumar wrote:
> Following is what i understood after reading m25p80 driver and spi 
> master drivers in drivers/spi folder.
> 
> "chip_select signal controls start and end of transfer. For ex: if we have to read
> status reg of spi memory, then we use write_and_then_read() routine. which writes
> 0x9F in one spi transfer and writes dummy bytes and reads rx reg in other transfer.
> And these two transfers are part of single spi_message.
> 
> Now, it is controllable to handle cs, and if we send cs_change == 0, then chip select
> is activated at start of message and deactivated at end of message, instead at end
> of every transfer.
> 
> Which means, even if there is a delay between command and dummy bytes received at
> spi memory, current transfer will not be terminated by memory as cs is low."
> 
> Is this correct??
> 
> Actually i am seeing a different behavior by some of the spi memories, like m25p10.
> If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
> returned in response. If there is no delay then transfer always passes.

What SPI controller are you using?  I've seen a similar issue with the 
Synopsys DesignWare SPI controller where the controller manages the chip 
select itself, and once the FIFO is emptied the CS goes away, but the 
flash chip requires it to stay high for the whole transaction.  In this 
case the workaround is to use a GPIO as a chip select and there are 
other controllers that do the same thing for the same reason (I think 
that pxa2xx_spi is one of them).

Jamie
