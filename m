From: Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Accelerometer,
 Gyros and ADC's etc within the kernel.
Date: Tue, 27 May 2008 19:00:56 +0100
Message-ID: <483C4C58.5080301@gmail.com>
References: <4832A211.4040206@gmail.com>
	<20080527164415.GA27584@polina.dev.rtsoft.ru>
	<20080527165021.GA22585@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080527165021.GA22585-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


>
> The two drivers i've seen so far use the input subsystem to report
> their data to the user. I'm working on an driver for the SMB380 which
> can be both i2c and spi.
Yes, the ST accel I'm using (LIS3L02DQ) is like that as well, so we 
definitely need
to implement the ability to do this cleanly! 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
