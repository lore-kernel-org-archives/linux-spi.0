From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: tegra: don't treat NULL clk as an error
Date: Mon, 10 Jan 2011 16:43:21 -0700
Message-ID: <20110110234321.GA1846@angua.secretlab.ca>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
	<20110110221802.GD12552@n2100.arm.linux.org.uk>
	<20110110222524.GE12552@n2100.arm.linux.org.uk>
	<AANLkTinOWvu5TNMtsrw19-ERc1JpopvQkyp0QH3sQpkL@mail.gmail.com>
	<20110110233033.GG12552@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jamie Iles <jamie@jamieiles.com>, Erik Gilling <konkers@android.com>,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110110233033.GG12552@n2100.arm.linux.org.uk>
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

On Mon, Jan 10, 2011 at 11:30:33PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 10, 2011 at 04:24:17PM -0700, Grant Likely wrote:
> > I was actually looking at the implementation of clk_enable() which is
> > called by the driver and doesn't do any NULL checking.  But I suppose
> > that it then becomes the clock-code's own fault if it returns NULL and
> > then oopses on a NULL being passed to it.  Okay, I'll apply it.
> 
> Yes absolutely.  The clk API must eat whatever cookies it produces,
> even if they contain dead flies rather than currants. ;)

nice analogy.  :-)

g.
