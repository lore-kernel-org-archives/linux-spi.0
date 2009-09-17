From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH] mpc52xx_psc_spi: enlarge clock range
Date: Thu, 17 Sep 2009 08:13:29 -0600
Message-ID: <fa686aa40909170713v4c447ce2s3b4d18e15a1a2c17@mail.gmail.com>
References: <4AB0C706.5020601@toptica.com>
	<20090916204853.GA21627@pengutronix.de>
	<4AB241FA.9090604@toptica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
To: Dragos Carp <dragos.carp@toptica.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4AB241FA.9090604@toptica.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 17, 2009 at 8:04 AM, Dragos Carp <dragos.carp@toptica.com> wrote:
> Hi,
>
> I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
> couldn't find any MPC5200 user manual on Freescale's webpage.
> Is there a #define that I can use to distinguish between the two
> processor variants? Querying the PVR register is not a nice solution
> because the chip-select activate function is called in some scenarios
> quite often.

Use the compatible value.  That's what it is there for.  Only use the
extended register format if "fsl,mpc5200b-psc-spi" is present in the
compatible list.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
