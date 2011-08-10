From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 10:00:42 +0100
Message-ID: <20110810090042.GE1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: pratyush.anand@st.com, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com,
	bhupesh.sharma@st.com, armando.visconti@st.com,
	linus.walleij@linaro.org, jassisinghbrar@gmail.com,
	vipin.kumar@st.com, grant.likely@secretlab.ca,
	shiraz.hashim@st.com, amit.virdi@st.com, vipulkumar.samar@st.com,
	viresh.linux@gmail.com, deepak.sikri@st.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
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

On Wed, Aug 10, 2011 at 02:20:59PM +0530, Viresh Kumar wrote:
> Currently we request DMA channels at probe time and free them at remove. They
> are always occupied, irrespective of their usage.
> 
> They must be allocated when they are required and must be freed after we are
> done with transfers. So that they can be used by other users.

Which DMA engine driver requires this?

Normally, when we have DMA engine drivers with multiple request signals,
the slave peripheral side publishes several virtual channels which are
claimed by the peripheral drivers.  This (amongst other things) allows
the peripheral drivers to hold claim to one of the virtual channels
all the time that it's required.

This actually results in better usage of the DMA controller, as the
virtual channels can be assigned to physical channels dynamically
according to what the physical channels are doing.

Plus, actually, the idea that DMA channels should be a short-term thing
is broken as soon as you start considering things like UARTs, where you
need a channel tied up long-term for the receive side of things.
