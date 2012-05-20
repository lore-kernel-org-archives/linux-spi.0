From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to
	of_modalias_node().
Date: Sun, 20 May 2012 00:08:01 -0600
Message-ID: <20120520060802.03CE73E03B8@localhost>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
	<1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
	<20120520055436.13AF03E03B8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	David Daney <david.daney@cavium.com>,
	Takashi Iwai <tiwai@suse.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
To: David Daney <ddaney.cavm@gmail.com>, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120520055436.13AF03E03B8@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Sat, 19 May 2012 23:54:36 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, 11 May 2012 15:05:21 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > When generating MODALIASes, it is convenient to add things like "spi:"
> > or "i2c:" to the front of the strings.  This allows the standard
> > modprobe to find the right driver when automatically populating bus
> > children from the device tree structure.
> > 
> > Add a prefix parameter, and adjust callers.  For
> > of_register_spi_devices() use the "spi:" prefix.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Applied, thanks.  Some notes below...

Wait... why is this necessary?  The module type prefix isn't stored in
the modalias value for any other bus type as far as I can see, and
with this series it appears that the "spi:" prefix may or may not be
present in the modalias.  That doesn't look right.

Why isn't prefixing spi: at uevent time sufficient?  IIUC, modprobe
depends on either UEVENT or the modalias attribute to know which
driver to probe.  It does look like the attribute is missing the spi:
prefix though.  Does the following change work instead of these two
patches?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3d8f662..da8aac7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -51,7 +51,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 {
        const struct spi_device *spi = to_spi_device(dev);
 
-       return sprintf(buf, "%s\n", spi->modalias);
+       return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
 }

So, I've dropped this patch from my tree.  If the change above works
for you then I'll push it out.

g.
