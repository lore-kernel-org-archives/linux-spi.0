From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH V3 5/5] staging:iio:magnetometer:ak8975: Fix probe()
	error-handling
Date: Thu,  1 Sep 2011 16:04:31 -0600
Message-ID: <1314914676-28397-5-git-send-email-swarren@nvidia.com>
References: <1314914676-28397-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Andrew Chew <achew@nvidia.com>,
	Stephen Warren <swarren@nvidia.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	spi-devel-general@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, linux-i2c@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Ben Dooks <ben-linux@fluff.org>, Jonathan Cameron <jic23@cam.ac.uk>,
	Grant Likely <grant.likely@secretlab.ca>, A
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314914676-28397-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
List-Id: linux-spi.vger.kernel.org

Fix ak8975_probe() to jump to the appropriate exit labels when an error
occurs. With the previous code, some cleanup actions were being skipped
for some error conditions.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/staging/iio/magnetometer/ak8975.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 0dfdf50..cc20e8d 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -510,7 +510,7 @@ static int ak8975_probe(struct i2c_client *client,
 	err = ak8975_setup(client);
 	if (err < 0) {
 		dev_err(&client->dev, "AK8975 initialization fails\n");
-		goto exit_gpio;
+		goto exit_free_iio;
 	}
 
 	i2c_set_clientdata(client, indio_dev);
-- 
1.7.0.4
