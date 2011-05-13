From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
Date: Fri, 13 May 2011 10:04:03 +0100
Message-ID: <20110513090403.GK8718@pulham.picochip.com>
References: <4DCA0B77.8060700@st.com>
 <4DCCAB19.2020302@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dinesh Kumar SHARMA <dinesh.sharma@st.com>,
	"linus.walleij@stericsson.com" <linus.walleij@stericsson.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>, Jamie Iles <jamie@jamieiles.com>,
	spi-devel-general@lists.sourceforge.net,
	Vikas MANOCHA <vikas.manocha@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DCCAB19.2020302@st.com>
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

On Fri, May 13, 2011 at 09:22:57AM +0530, viresh kumar wrote:
> On 05/11/2011 09:37 AM, viresh kumar wrote:
> > Actually i am seeing a different behavior by some of the spi 
> > memories, like m25p10.
> > If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
> > returned in response. If there is no delay then transfer always passes.
> > 
> 
> Linus, Jamie,
> 
> Have you ever seen this kind of issue? Which spi slave memories did you used for testing?
> I am using standard pl0022 and m25p80 driver. Tried in all modes: polling, interrupt, dma.

No, not that exact issue.  I've seen with the Synopsys DesignWare 
controller that the fifo emptying causing cs to drop can result in all 
0's being read back from a m25p80, but not all 1's.

Jamie
