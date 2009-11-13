From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [V2] Patches for mpc52xx_spi
Date: Fri, 13 Nov 2009 11:53:23 -0700
Message-ID: <fa686aa40911131053xec0774ey33e451b6233ff6c4@mail.gmail.com>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
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

On Fri, Nov 13, 2009 at 3:41 AM, Luotao Fu <l.fu@pengutronix.de> wrote:
>
> Hi Grand,
>
> here are the V2 of my patchset for mpc52xx_spi. Besides Wolframs suggestions I
> also added some more fixes. Details of changes can be checked in the patch
> header. Please do consider to apply the patches. The patch 1/2 e.g. fix bugs,
> which prevent the driver to work in some cases, as seen on my board.

Applied to my 'test' branch on git.secretlab.ca

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
