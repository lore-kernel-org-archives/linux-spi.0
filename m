Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716644;
	b=KKDzzAmybbysDF6+WoXUYdKhNHCbV9vUIJSOnhXwSxKVMaJGcbBWoY98Rvs8pY19Ne2n
	 Z9fgFxNYHh7G4g1CrImdIT/HoJ1hEV1++waRWvzEkYBeobNjbWOP1QlF56PSCAsCiWA8V
	 D8qoqXyG7ZY6sFcO163Y4+O6i6MpFRl4Ygpox16t7lk+5asWpstlmPKBQui3SBu5UdAMO
	 XWJg5N8+qQ04x5L2NR4LM8V7BhFtHtk9vlijb4PqDFgimAmUQqFrW6ztI6DL0vrr6OfzX
	 mzpmajeFphniN3rS2GBlgZASKbrVTwsMak+T2hYTEUuduwC0PTR/21Npy1C+wStidkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716644;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=R7AG+x6Pl0IWkRABku8FUiuT3RJgbICHIruA7A37TDw=;
	b=qvBycZyoOP+wofZ41T45DE1LYLHHa7A6i5tp1lWmfY5NKduwK0B7vXKCldoqGt3Y2f+P
	 jwwBEb+7Qqx/uI6P2ozxudVf/nBebJotBtgPswPKUniu+RU56o2We9I06+UxmEf5DgQHE
	 E+gGq0Jgaia1DuaudBh1zNUnbvxK8z1Gc5V2Gwfd+dvsXRwuZ9dj2HsT3T6YFIpgnPo2I
	 Dj0EBLCpY/j0gPXqyvCT8tJbkC8r2ApXC0WSjK26AeZw7fbP2qHn9XBf9pAgPs2G1hI+e
	 ToDUSwc+YNgB8w/TOCK6Fc06ePiPGqUUmLVy2GXJ2/l4b/6U3MomE9bvYMDMQl+zGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO1THz73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96850606A335;
	Thu, 26 Nov 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO1THz73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D9D1F000C6;
	Thu, 26 Nov 2026 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716644;
	bh=R7AG+x6Pl0IWkRABku8FUiuT3RJgbICHIruA7A37TDw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FO1THz73GU0Sj/2ncXwL8wvvXhBz9v3YYZvDNGqdTiXEp3rp6ZQPaOuMQFAMUvjJR
	 0DPnQzhuHmId1+AXUfSVDNqT2Y/f72saM3xd98VvJje5q8ek89Y/F4kYs4mNCq5HdK
	 Y9zPRpF+kL7W3TyjMxZs7utBqsnfOAWZeUE1J93BWVRoiSm6ISrCGSIB839jAq5FDc
	 ZohTUUThkvLVbK3bNuzYbYQg6P+4dXcvVYtL32HE7yw90I2CWl9iTp7NzBs/iQkz8P
	 MEyBSnTJNHq3gr9wpBXswPgD+yPQEmgaC2lQoVdMHPObg7juAjtoblxzKxCUuoy3d1
	 EaQ5KMHUGEOWQ==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] spi: ljca: Do not wait for an ack after every write
 chunk
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Lixu Zhang <lixu.zhang@intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20261125134941.309622-1-pmenzel@molgen.mpg.de>
References: <20261125134941.309622-1-pmenzel@molgen.mpg.de>
Date: Thu, 26 Nov 2026 18:10:33 +0000
Message-Id: <179571663369.142532.14025601589162853266.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZCYPWshA5oO9o8zLbb3Al8I1oY9yeJIozdKxF+qRDv4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5yqQ/PMr5Ms/e9arTwoV7f26a+z24RdXtU8wJDeGwV
 xwLhOu/dpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAi1a8YGT7esdIT+WJgo2nq
 HbheLXjyqW3Vt1bO3Hh15iPjEPntBakMfzj7je8zidnlcLDvq+szOfViZp7Xc0e/XZO/fxH8d7T
 pLCMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The LJCA adapter in the Dell XPS 9315 (8086:0b63) is a USB Full Speed
> device with 64-byte bulk endpoints, so ljca_spi_transfer() splits each
> SPI transfer into chunks of 58 bytes, and ljca_transfer() waits for the
> adapter’s ack after each of them. On the Full Speed bus, every such
> round trip takes about 0.3 ms.
> 
> This is most visible when mei_vsc boots the Intel Visual Sensing
> Controller (IVSC): it downloads about 1.7 MB of firmware with write-only
> SPI transfers, which takes about 12 seconds. Tracing `modprobe mei_vsc`
> with the function_graph tracer:
> 
>     SPI device statistics:   1730864 bytes in 3407 transfers
>     ljca_send():             30085 calls, median 279 us, 11.1 s in total
>       usb_bulk_msg() (OUT):  median 133 us, 4.6 s in total
>       waiting for the ack:   median 146 us, 6.5 s in total
> 
> Only request an ack for the last chunk of a write, and send the others
> with ljca_transfer_noack(). Bulk messages arrive in order, so the
> transfer still completes only after the adapter has handled all chunks.
> A write chunk then takes 112 us (median) instead of 279 us. Reads and
> full-duplex transfers are unchanged, as each of their chunks returns
> data.
> 
> On the Dell XPS 9315, with Debian’s 7.3.5 kernel and only spi-ljca.ko
> rebuilt with this change, `modprobe mei_vsc` (mei_vsc blacklisted, so
> that the IVSC is in its reset state), two boots each:
> 
>     without this change:  12.28 s, 12.08 s
>     with this change:      7.56 s,  7.34 s
> 
> Both cases transfer the same 1730864 bytes in 3407 transfers, the IVSC
> boots, the IPU6 finds the sensor, and libcamera captures frames.
> 
> Sending several of the 64-byte messages in one bulk transfer was slower
> (8.4 to 8.6 s for 8 messages), as the adapter seems to NAK the next
> packet while it still forwards the previous chunk over SPI.
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

-- 
Mark Brown <broonie@kernel.org>
