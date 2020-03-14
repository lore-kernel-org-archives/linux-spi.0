From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 05/12] spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
Date: Sun, 15 Mar 2020 00:43:33 +0200
Message-ID: <20200314224340.1544-6-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200314224340.1544-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

dspi->words_in_flight is a variable populated in the *_write functions
and used in the dspi_fifo_read function. It is also used in
dspi_fifo_write, immediately after transmission, to update the
message->actual_length variable used by higher layers such as spi-mem
for integrity checking.

But it may happen that the IRQ which calls dspi_fifo_read to be
triggered before the updating of message->actual_length takes place. In
that case, dspi_fifo_read will decrement dspi->words_in_flight to -1,
and that will cause an invalid modification of message->actual_length.

Make the simplest fix possible: don't decrement the actual shared
variable in dspi->words_in_flight from dspi_fifo_read, but actually a
copy of it which is on stack.

Suggested-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 51224b772680..3ac004aa2abd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -765,8 +765,10 @@ static u32 dspi_popr_read(struct fsl_dspi *dspi)
 
 static void dspi_fifo_read(struct fsl_dspi *dspi)
 {
+	int num_fifo_entries = dspi->words_in_flight;
+
 	/* Read one FIFO entry and push to rx buffer */
-	while (dspi->words_in_flight--)
+	while (num_fifo_entries--)
 		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
-- 
2.17.1
