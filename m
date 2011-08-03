From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: spi/spi-pl022: Query on working of DMA mode
Date: Wed, 3 Aug 2011 16:58:53 +0200
Message-ID: <CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
References: <4E3931B7.3010400@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linus.walleij@stericsson.com" <linus.walleij@stericsson.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	viresh kumar <viresh.linux@gmail.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E3931B7.3010400@st.com>
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

On Wed, Aug 3, 2011 at 1:32 PM, viresh kumar <viresh.kumar@st.com> wrote:

> tasklet_schedule(pump_transfers)
> pump_transfers(unsigned long data)
> configure_dma(pl022)
> sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNEL);
>
> Here, allocation is requested with GFP_KERNEL flag, from a tasklet.
> Which gives following crash logs:

What happens if you replace it with GFP_NOWAIT?

That should work for everybody.

Or you could remove the tasklet allover and replace it with a workqueue.

> Is DMA mode working in your case?

Yes, magically :-/

Yours,
Linus Walleij
